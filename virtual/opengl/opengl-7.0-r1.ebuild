# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/opengl/opengl-7.0-r1.ebuild,v 1.6 2014/04/08 20:03:11 ago Exp $

EAPI=5

inherit multilib-build

DESCRIPTION="Virtual for OpenGL implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	|| (
		media-libs/mesa[${MULTILIB_USEDEP}]
		media-libs/opengl-apple
	)"
DEPEND=""
