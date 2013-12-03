# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxshmfence/libxshmfence-1.1.ebuild,v 1.2 2013/12/03 00:47:59 mattst88 Exp $

EAPI=5
XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="Shared memory fences using futexes"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
