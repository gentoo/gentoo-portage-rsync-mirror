# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-php/eselect-php-0.6.7.ebuild,v 1.5 2012/09/12 03:04:01 ottxor Exp $

EAPI=4

DESCRIPTION="PHP eselect module"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~olemarkus/eselect-php/eselect-php-${PV}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND=">=app-admin/eselect-1.2.4"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	mv eselect-php-${PV} php.eselect
	insinto /usr/share/eselect/modules/
	doins php.eselect
}
