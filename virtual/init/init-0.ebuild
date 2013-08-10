# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/init/init-0.ebuild,v 1.17 2013/08/10 16:45:45 williamh Exp $

DESCRIPTION="Virtual for various init implementations"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="!prefix? (
	kernel_linux? ( || ( >=sys-apps/sysvinit-2.86-r6 sys-process/runit
		sys-apps/systemd ) )
	kernel_FreeBSD? ( sys-freebsd/freebsd-sbin )
	)"
DEPEND=""
