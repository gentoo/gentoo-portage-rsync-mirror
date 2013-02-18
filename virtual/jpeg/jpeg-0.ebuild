# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jpeg/jpeg-0.ebuild,v 1.10 2013/02/18 01:06:08 zmedico Exp $

EAPI=4

DESCRIPTION="A virtual for the JPEG implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND="|| (
		>=media-libs/libjpeg-turbo-1.2.0:0[static-libs?]
		>=media-libs/jpeg-8d:0[static-libs?]
		)"
DEPEND=""
