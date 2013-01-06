# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xbox-sources/xbox-sources-2.6.16.26.ebuild,v 1.2 2007/01/02 01:49:25 dsd Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE='sources'
K_SECURITY_UNSUPPORTED="1"
inherit kernel-2
detect_arch
detect_version

# version of gentoo patchset
XBOX_PATCHES=linux-2.6.16-xbox.patch.gz

KEYWORDS="~x86 -*"
UNIPATCH_LIST="
	${ARCH_PATCH}
	${DISTDIR}/${XBOX_PATCHES}"
DESCRIPTION="Full sources for the Xbox Linux kernel"
SRC_URI="${KERNEL_URI}
	${ARCH_URI}
	mirror://sourceforge/xbox-linux/${XBOX_PATCHES}"
