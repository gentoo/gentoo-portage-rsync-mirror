# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lafilefixer/lafilefixer-0.5.ebuild,v 1.16 2011/11/27 00:01:35 vapier Exp $

EAPI=2

DESCRIPTION="Utility to fix your .la files"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND=">=app-shells/bash-3.2
	elibc_glibc? ( >=sys-apps/findutils-4.4.0 )"

S=""

src_unpack() { : ; }
src_prepare() { : ; }
src_configure() { : ; }
src_unpack() { : ; }
src_install() {	newbin "${FILESDIR}/${P}" ${PN} ; }

pkg_postinst() {
	elog "This simple utility will fix your .la files to not point to other .la files."
	elog "This is desirable because it will ensure your packages are not broken when"
	elog ".la files are removed from other packages."
	elog ""
	elog "For most uses, lafilefixer --justfixit should 'just work'. This will"
	elog "recurse through the most commonly used library folders and fix all .la"
	elog "files it encounters."
	elog ""
	elog "Read lafilefixer --help for a full description of all options."
}
