# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libtxc_dxtn/libtxc_dxtn-1.0.1-r1.ebuild,v 1.1 2012/10/08 21:13:03 mgorny Exp $

EAPI=4

inherit autotools-multilib

DESCRIPTION="Helper library for	S3TC texture (de)compression"
HOMEPAGE="http://cgit.freedesktop.org/~mareko/libtxc_dxtn/"
SRC_URI="http://people.freedesktop.org/~cbrill/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="media-libs/mesa"
DEPEND="${RDEPEND}"

RESTRICT="bindist"

pkg_postinst() {
	ewarn "Depending on where you live, you might need a valid license for s3tc"
	ewarn "in order to be legally allowed to use the external library."
	ewarn "Redistribution in binary form might also be problematic."
	ewarn
	ewarn "You have been warned. Have a nice day."
}
