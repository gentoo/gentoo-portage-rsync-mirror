# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/udev/udev-0.ebuild,v 1.6 2012/12/12 15:32:42 axs Exp $

EAPI=2

DESCRIPTION="Virtual for udev implementation and number of its features"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="gudev hwdb keymap selinux static-libs"

DEPEND=""
RDEPEND="gudev? ( <sys-fs/udev-171[extras] )
	hwdb? ( || ( <sys-fs/udev-171[extras] ~sys-fs/udev-141 ) )
	keymap? ( || ( <sys-fs/udev-171[extras] ~sys-fs/udev-141 ) )
	<sys-fs/udev-171[selinux?]"
