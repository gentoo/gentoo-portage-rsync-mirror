# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/opencl/opencl-0-r2.ebuild,v 1.4 2012/07/14 19:43:11 ulm Exp $

EAPI="4"

DESCRIPTION="Virtual for OpenCL implementations"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
CARDS=( fglrx nvidia )
IUSE="${CARDS[@]/#/video_cards_}"

DEPEND=""
RDEPEND="app-admin/eselect-opencl
	|| (
		video_cards_fglrx? ( >=x11-drivers/ati-drivers-12.1-r1 )
		video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-290.10-r2 )
		dev-util/intel-ocl-sdk
	)"
