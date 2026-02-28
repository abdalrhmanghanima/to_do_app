import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/presentation/home/cubit/to_do_cubit.dart';

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({super.key});

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  final titleController = TextEditingController();

  final descController = TextEditingController();
  DateTime? selectedDate;
  XFile? selectedImage;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: Color(0xFFE5738C),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 20),

              _buildField(hint: "Title", controller: titleController),

              const SizedBox(height: 16),

              _buildField(
                hint: "Description",
                controller: descController,
                maxLines: 6,
              ),

              const SizedBox(height: 16),

              GestureDetector(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: _buildField(
                    hint: selectedDate == null
                        ? "Deadline (Optional)"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    icon: Icons.calendar_today,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final picked = await picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (picked != null) {
                    setState(() {
                      selectedImage = picked;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: _buildField(
                    hint: selectedImage == null
                        ? "Add Image (Optional)"
                        : selectedImage!.name,
                    icon: Icons.image_outlined,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    final title = titleController.text.trim();
                    final desc = descController.text.trim();

                    if (title.isEmpty || desc.isEmpty) {
                      setState(() {
                        errorMessage = "Please fill all fields";
                      });
                      return;
                    }

                    await context.read<TodoCubit>().addTodo(
                      title,
                      desc,
                      selectedDate,
                      selectedImage,
                    );

                    Navigator.pop(context);
                  },

                  child: const Text(
                    "ADD TODO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String hint,
    TextEditingController? controller,
    int maxLines = 1,
    IconData? icon,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,

      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),

        suffixIcon: icon != null ? Icon(icon, color: Colors.white70) : null,

        filled: true,
        fillColor: Colors.transparent,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
