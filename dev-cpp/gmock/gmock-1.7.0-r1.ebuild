# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gmock/gmock-1.7.0-r1.ebuild,v 1.1 2014/03/27 02:35:20 vapier Exp $

EAPI="4"

inherit libtool multilib-minimal

DESCRIPTION="Google's C++ mocking framework"
HOMEPAGE="http://code.google.com/p/googlemock/"
SRC_URI="http://googlemock.googlecode.com/files/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="static-libs"

RDEPEND="=dev-cpp/gtest-${PV}*[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	default
	# make sure we always use the system one
	rm -r "${S}"/gtest/{Makefile,configure}* || die
}

src_prepare() {
	sed -i -r \
		-e '/^install-(data|exec)-local:/s|^.*$|&\ndisabled-&|' \
		Makefile.in
	elibtoolize
}

multilib_src_configure() {
	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}

multilib_src_install() {
	default
	dobin scripts/gmock-config
}

multilib_src_install_all() {
	use static-libs || find "${ED}" -name '*.la' -delete
}
