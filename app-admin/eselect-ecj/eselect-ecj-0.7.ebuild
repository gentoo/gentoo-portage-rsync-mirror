# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-ecj/eselect-ecj-0.7.ebuild,v 1.8 2013/04/06 10:23:49 caster Exp $

EAPI=4

DESCRIPTION="Manages ECJ symlinks"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ia64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.3
	!app-admin/eselect-java"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${FILESDIR}/ecj-${PV}.eselect" ecj.eselect || die "newins failed"
}
