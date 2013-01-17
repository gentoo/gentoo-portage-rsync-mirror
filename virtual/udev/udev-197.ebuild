# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/udev/udev-197.ebuild,v 1.1 2013/01/17 17:43:10 ssuominen Exp $

EAPI=2

DESCRIPTION="Virtual to select between sys-fs/udev and sys-fs/eudev"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="gudev hwdb introspection keymap selinux static-libs"

DEPEND=""
RDEPEND="|| ( >=sys-fs/udev-197-r2[gudev?,hwdb?,introspection?,keymap?,selinux?,static-libs?]
	>=sys-fs/eudev-1_beta1[gudev?,hwdb?,introspection?,keymap?,selinux?,static-libs?] )"
