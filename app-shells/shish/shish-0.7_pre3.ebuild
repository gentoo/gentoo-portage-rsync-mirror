# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/shish/shish-0.7_pre3.ebuild,v 1.3 2008/03/14 20:45:42 hollow Exp $

inherit toolchain-funcs

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

DESCRIPTION="The diet shell"
HOMEPAGE="http://www.blah.ch/shish/"
SRC_URI="http://www.blah.ch/${PN}/pkg/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug diet"

DEPEND="diet? ( dev-libs/dietlibc )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use diet && export CC="diet $(tc-getCC) -nostdinc"
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"

	# parallel make is b0rked
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	doman doc/man/shish.1
	dodoc AUTHORS BUGS README TODO ChangeLog
}

pkg_postinst() {
	einfo "Updating ${ROOT}etc/shells"
	( grep -v "^/bin/shish$" "${ROOT}"etc/shells; echo "/bin/shish" ) > "${T}"/shells
	mv -f "${T}"/shells "${ROOT}"etc/shells
}
