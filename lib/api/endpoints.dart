
class Endpoints {

  static const apiAddress = "http://migmig.papou.ir/api/";
  static const homeData = apiAddress + "main/home-data";
  static const mainData = apiAddress + "main/main-data";
  static const uploadUrl = 'http://migmig.papou.ir/uploader/image';
  static const paymentUrl = 'http://migmig.papou.ir/pay/';

  static const getPage = apiAddress + "main/page/";
  static const contact = apiAddress + "main/contact/";

  //user
  static const register = apiAddress + "account/register";
  static const login = apiAddress + "account/login";
  static const verifyLogin = apiAddress + "account/verify-login";
  static const userInfo = apiAddress + "account/info";
  static const profileData = apiAddress + "account/profile/";
  static const editProfile = apiAddress + "account/edit-profile";
  static const checkInfo = apiAddress + "account/check-info";
  static const forgotPassword = apiAddress + "account/forgot-password";
  static const updatePassword = apiAddress + "account/update-password";


  //orders
  static const createOrder = apiAddress + "orders/create";
  static const orders = apiAddress + "orders/";
  static const checkOrderStatus = apiAddress + "orders/check-status";
  static const calculatePrice = apiAddress + "orders/calculate";
  static const cancelOrder = apiAddress + "orders/cancel-order";


}