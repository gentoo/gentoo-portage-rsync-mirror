# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/awk/awk-0.ebuild,v 1.6 2013/02/11 20:42:16 ssuominen Exp $

DESCRIPTION="Virtual for awk implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND="
	|| (
		sys-apps/gawk
		sys-apps/mawk
		sys-apps/nawk
		sys-apps/busybox
	)"
