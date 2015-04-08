# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-eselect/eselect-cdparanoia/eselect-cdparanoia-0.1.ebuild,v 1.1 2015/03/31 16:47:19 ulm Exp $

EAPI=5

DESCRIPTION="Manage /usr/bin/cdparanoia symlink"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=app-eselect/eselect-lib-bin-symlink-0.1.1
	!<media-sound/cdparanoia-3.10.2-r5"
DEPEND=${RDEPEND}

S=${FILESDIR}

src_install() {
	insinto /usr/share/eselect/modules
	newins cdparanoia.eselect-${PV} cdparanoia.eselect
}
