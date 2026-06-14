import 'package:test/test.dart';
import 'package:user_remote_source/user_remote_source.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('User Mapping', () {
    test('transform UserResponse to UserEntity object correctly', () {
      const userResponse = UserResponse(
        id: 1,
        name: 'user.name',
        username: 'user.username',
        email: 'user.email',
        address: AddressResponse(
          street: 'user.address?.street',
          suite: 'user.address?.suite',
          city: 'user.address?.city',
          zipcode: 'user.address?.zipcode',
          geo: GeoResponse(
            lat: 'user.address?.geo?.lat',
            lng: 'user.address?.geo?.lng',
          ),
        ),
        phone: 'user.phone',
        website: 'user.website',
        company: CompanyResponse(
          name: 'user.company?.name',
          catchPhrase: 'user.company?.catchPhrase',
          bs: 'user.company?.bs',
        ),
      );
      const userEntity = UserEntity(
        id: 1,
        name: 'user.name',
        username: 'user.username',
        email: 'user.email',
        address: AddressEntity(
          street: 'user.address?.street',
          suite: 'user.address?.suite',
          city: 'user.address?.city',
          zipcode: 'user.address?.zipcode',
          geo: GeoEntity(
            lat: 'user.address?.geo?.lat',
            lng: 'user.address?.geo?.lng',
          ),
        ),
        phone: 'user.phone',
        website: 'user.website',
        company: CompanyEntity(
          name: 'user.company?.name',
          catchPhrase: 'user.company?.catchPhrase',
          bs: 'user.company?.bs',
        ),
      );
      expect(
        userResponse.toEntity(),
        userEntity,
      );
    });
  });
}
