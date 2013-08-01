# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jpeg/jpeg-62.ebuild,v 1.1 2013/08/01 20:27:39 ssuominen Exp $

EAPI=5

inherit multilib-build

DESCRIPTION="A virtual for the JPEG implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="62"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="|| (
		>=media-libs/libjpeg-turbo-1.3.0-r2:0[${MULTILIB_USEDEP}]
		media-libs/jpeg:62[${MULTILIB_USEDEP}]
		)"
DEPEND=""
