# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mutrace/mutrace-0.2.ebuild,v 1.2 2009/11/23 10:05:19 robbat2 Exp $

EAPI="2"

inherit base

DESCRIPTION="mutrace is a mutex tracer/profiler"
HOMEPAGE="http://0pointer.de/blog/projects/mutrace.html"
SRC_URI="http://0pointer.de/public/${P}.tar.gz"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

DEPEND="sys-devel/binutils"
RDEPEND="${DEPEND}"

DOCS="README GPL2 GPL3 LGPL3"
