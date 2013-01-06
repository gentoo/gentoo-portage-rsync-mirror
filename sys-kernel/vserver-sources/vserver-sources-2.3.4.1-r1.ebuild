# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-2.3.4.1-r1.ebuild,v 1.1 2012/08/24 03:30:34 patrick Exp $

ETYPE="sources"
CKV="3.5.2"

K_USEPV=1
K_NOSETEXTRAVERSION=1

inherit kernel-2
detect_version

KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DESCRIPTION="Full sources including Linux-VServer patchsets for the ${KV_MAJOR}.${KV_MINOR} kernel tree."
HOMEPAGE="http://www.gentoo.org/proj/en/vps/"
SRC_URI="${KERNEL_URI} ${ARCH_URI}
	http://vserver.13thfloor.at/Experimental/patch-${CKV}-vs${PV}.diff"

UNIPATCH_LIST="${DISTDIR}/patch-${CKV}-vs${PV}.diff"
UNIPATCH_STRICTORDER=1
