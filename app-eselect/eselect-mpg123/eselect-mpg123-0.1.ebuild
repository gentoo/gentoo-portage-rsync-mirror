# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-eselect/eselect-mpg123/eselect-mpg123-0.1.ebuild,v 1.1 2015/03/31 16:51:42 ulm Exp $

EAPI=5

DESCRIPTION="Manage /usr/bin/mpg123 symlink"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=app-eselect/eselect-lib-bin-symlink-0.1.1
	!<media-sound/mpg123-1.14.4-r1"
DEPEND=${RDEPEND}

S=${FILESDIR}

src_install() {
	insinto /usr/share/eselect/modules
	newins mpg123.eselect-${PV} mpg123.eselect
}
