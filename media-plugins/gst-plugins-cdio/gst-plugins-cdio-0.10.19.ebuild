# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdio/gst-plugins-cdio-0.10.19.ebuild,v 1.14 2013/02/04 09:53:19 ago Exp $

EAPI="5"

inherit eutils gst-plugins-ugly

KEYWORDS="alpha amd64 ~arm ~ia64 ppc ppc64 ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/libcdio-0.80:="
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-cdio-cd-text-api.patch #452434
}
