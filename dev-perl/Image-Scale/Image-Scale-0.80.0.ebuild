# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Image-Scale/Image-Scale-0.80.0.ebuild,v 1.1 2012/04/04 16:48:53 tove Exp $

EAPI=4

MODULE_AUTHOR=AGRUNDMA
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Fast, high-quality fixed-point image resizing"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL2+
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gif jpeg png test"

REQUIRED_USE="|| ( jpeg png )"

RDEPEND="
	png? (
		media-libs/libpng:0
	)
	jpeg? (
		media-libs/libjpeg-turbo
	)
	gif? (
		media-libs/giflib
	)
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-NoWarnings
	)
	virtual/perl-ExtUtils-MakeMaker
"

SRC_TEST=do
PATCHES=(
	"${FILESDIR}"/libpng-1.5-memcpy.patch
	"${FILESDIR}"/0.80.0-disable_autodetect.patch
)
disable_use() {
	use $1 || echo "--disable-$useflag"
}
src_configure() {
	for useflag in png jpeg gif; do
		myconf+=( $(disable_use $useflag ) )
	done
	perl-module_src_configure
}
