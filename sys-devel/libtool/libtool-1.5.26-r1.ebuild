# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.5.26-r1.ebuild,v 1.3 2013/03/12 14:23:05 vapier Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="http://www.gnu.org/software/libtool/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.5"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${P}/libltdl

src_prepare() {
	epunt_cxx
}

src_configure() {
	econf --disable-static || die
}

src_install() {
	emake DESTDIR="${D}" install-exec || die
	# basically we just install ABI libs for old packages
	rm "${D}"/usr/*/libltdl.{la,so} || die
}
