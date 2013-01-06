# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/galago-sharp/galago-sharp-0.5.0-r1.ebuild,v 1.4 2012/05/04 03:56:57 jdhore Exp $

inherit eutils mono autotools

DESCRIPTION="Mono bindings to Galago"
HOMEPAGE="http://galago-project.org"
SRC_URI="http://galago-project.org/files/releases/source/${PN}/${P}.tar.gz
	http://galago-project.org/files/releases/source/libgalago/libgalago-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.0
		 >=sys-apps/dbus-0.90
		 =dev-dotnet/gtk-sharp-2*
		 >=dev-libs/libgalago-0.5.0"
DEPEND="${RDEPEND}
		virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Hard enable/disable tests
	epatch "${FILESDIR}/${PN}-0.5.0-tests.patch"

	# Nasty hack to prevent building of the tests
	sed -i -e 's/ tests//' "${S}/Makefile.am"

	sed -i -e 's:\$(GET_METHOD)::' "${S}"/sources/Makefile.am || die

	mv "${WORKDIR}"/libgalago-${PV} "${S}"/sources/libgalago

	eautoreconf
}

src_compile() {
	econf --disable-tests || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
