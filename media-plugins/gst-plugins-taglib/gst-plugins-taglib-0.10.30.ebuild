# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-taglib/gst-plugins-taglib-0.10.30.ebuild,v 1.8 2012/12/02 16:37:20 eva Exp $

EAPI="3"

inherit gst-plugins-good

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.33:0.10
	>=media-libs/taglib-1.5"
DEPEND="${RDEPEND}"
