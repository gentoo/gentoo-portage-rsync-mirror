# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/opencl/opencl-0-r4.ebuild,v 1.1 2013/09/21 17:10:28 mgorny Exp $

EAPI=5

inherit multilib-build

DESCRIPTION="Virtual for OpenCL implementations"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
CARDS=( fglrx nvidia )
IUSE="${CARDS[@]/#/video_cards_}"

DEPEND=""
RDEPEND="app-admin/eselect-opencl
	|| (
		media-libs/mesa[opencl,${MULTILIB_USEDEP}]
		video_cards_fglrx? (
			>=x11-drivers/ati-drivers-12.1-r1[${MULTILIB_USEDEP}] )
		video_cards_nvidia? (
			>=x11-drivers/nvidia-drivers-290.10-r2[${MULTILIB_USEDEP}] )
		dev-util/intel-ocl-sdk[${MULTILIB_USEDEP}]
	)"
