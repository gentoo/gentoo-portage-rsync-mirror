# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ipp/ipp-7.1.0.079.ebuild,v 1.1 2012/10/09 20:38:37 jlec Exp $

EAPI=4
INTEL_DPN=parallel_studio_xe
INTEL_DID=2749
INTEL_DPV=2013
INTEL_SUBDIR=composerxe

inherit intel-sdp

DESCRIPTION="Intel Integrated Performance Primitive library for multimedia and data processing"
HOMEPAGE="http://software.intel.com/en-us/articles/intel-ipp/"

IUSE=""
DEPEND=""
RDEPEND=">=dev-libs/intel-common-13"

CHECKREQS_DISK_BUILD=3000M

INTEL_BIN_RPMS="ipp ipp-devel"
INTEL_DAT_RPMS="ipp-common"
