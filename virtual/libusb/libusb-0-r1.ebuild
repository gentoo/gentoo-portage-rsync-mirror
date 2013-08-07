# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/libusb/libusb-0-r1.ebuild,v 1.1 2013/08/07 16:11:21 ssuominen Exp $

EAPI=5
inherit multilib-build

DESCRIPTION="Virtual for libusb"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="|| ( >=dev-libs/libusb-compat-0.1.5-r2[${MULTILIB_USEDEP}] >=sys-freebsd/freebsd-lib-8.0[usb] )"
DEPEND=""
