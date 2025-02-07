import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.black,
    gravity: ToastGravity.TOP,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.red,
            ),
            const SizedBox(height: 18),
            Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading..."),
            )
          ],
        ),
      );
    }),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USER":
      return "Email này đã được sử dụng";
    case "account-exists-with-different-credential":
      return "Email này đã được sử dụng";
    case "email-already-in-use":
      return "Email này đã được sử dụng";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Sai mật khẩu";
    case "ERROR_USER_NOT_FOUND":
      return "Không tìm thấy người dùng này";
    case "user-not-found":
      return "Không tìm thấy người dùng này";
    case "ERROR_USER_DISABLED":
      return "Lỗi nguời dùng";
    case "user-disabled":
      return "Lỗi nguời dùng";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Quá nhiều yêu cầu đăng nhập vào tài khoản này";
    case "operation-not-allowed":
      return "Quá nhiều yêu cầu đăng nhập vào tài khoản này";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Quá nhiều yêu cầu đăng nhập vào tài khoản này";
    case "ERROR_INVALID_EMAIL":
      return "Email không hợp lệ";
    case "invalid-email":
      return "Email không hợp lệ";
    default:
      return "Lỗi đăng nhập. Vui lòng đăng nhập lại.";
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Hãy nhập Email và Password");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email chưa nhập");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password chưa nhập");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("Hãy nhập đầy đủ thông tin");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email chưa nhập");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password chưa nhập");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name chưa nhập");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone chưa nhập");
    return false;
  } else {
    return true;
  }
}
