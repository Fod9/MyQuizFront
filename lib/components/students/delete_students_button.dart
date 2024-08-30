import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:my_quiz_ap/helpers/colors.dart' show invalidColor;
import 'package:my_quiz_ap/providers/student_provider.dart' show Student, StudentProvider;

class DeleteStudentsButton extends StatefulWidget {
  const DeleteStudentsButton({super.key});

  @override
  State<DeleteStudentsButton> createState() => _DeleteStudentsButtonState();
}

class _DeleteStudentsButtonState extends State<DeleteStudentsButton> {

  late final _provider = Provider.of<StudentProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: MaterialButton(
        onPressed: () {
          displayDeletionDialog(context, _provider);
        },
        color: invalidColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text('Delete Selected Students', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class DeleteStudentsDialog extends StatefulWidget {
  const DeleteStudentsDialog({
    super.key,
    required this.provider,
  });

  final StudentProvider provider;

  @override
  State<DeleteStudentsDialog> createState() => _DeleteStudentsDialogState();
}

class _DeleteStudentsDialogState extends State<DeleteStudentsDialog> {

  bool _deleting = false;
  late final Student? _deletingStudent = widget.provider.deletingStudent;

  late final List<Widget> _yesNoWidgets = [
    const Text('Are you sure you want to delete the selected students?'),
    const Spacer(),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          onPressed: () async {
            setState(() {
              _deleting = true;
            });
            await widget.provider.deleteSelectedStudents();
            if (mounted) Navigator.of(context).pop();
          },
          color: Colors.red,
          child: const Text('Yes', style: TextStyle(color: Colors.white)),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.green,
          child: const Text('No', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: _deleting && _deletingStudent != null ? <Widget>[
              const CircularProgressIndicator(),
              Text(
                  'Deleting ${_deletingStudent.firstName} ${_deletingStudent.lastName}',
                  textAlign: TextAlign.center,
              ),
            ] : _yesNoWidgets,
          ),
        ),
      ),
    );
  }
}


void displayDeletionDialog(BuildContext context, StudentProvider provider) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteStudentsDialog(provider: provider);
    },
  );
}
