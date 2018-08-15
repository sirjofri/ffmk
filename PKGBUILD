# Maintainer: Joel Fridolin Meyer <sirjofri at sirjofri dot de>
pkgname=ffmk
pkgver=0.1
pkgrel=1
pkgdesc="a makefile-like farbfeld mixer"
arch=('any')
url="https://github.com/sirjofri/ffmk/"
license=('MIT')
depends=('perl')

package() {
	cd ..
	make PREFIX="/usr" PACKAGE="$pkgdir" package
	install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
