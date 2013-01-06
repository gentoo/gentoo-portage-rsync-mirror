# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-jai/ant-jai-1.7.1.ebuild,v 1.7 2011/12/31 10:12:04 sera Exp $

ANT_TASK_DEPNAME="sun-jai-bin"

inherit ant-tasks

KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

# unmigrated, has textrels and there's also some source one now too
DEPEND=">=dev-java/sun-jai-bin-1.1.2.01-r1"
RDEPEND="${DEPEND}"
