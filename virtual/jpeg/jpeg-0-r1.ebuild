# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jpeg/jpeg-0-r1.ebuild,v 1.2 2013/07/31 16:17:40 aballier Exp $

EAPI=5

inherit multilib-build

DESCRIPTION="A virtual for the JPEG implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND="|| (
		>=media-libs/libjpeg-turbo-1.3.0-r1:0[static-libs?,${MULTILIB_USEDEP}]
		>=media-libs/jpeg-8d-r1:0[static-libs?,${MULTILIB_USEDEP}]
		)"
DEPEND=""
