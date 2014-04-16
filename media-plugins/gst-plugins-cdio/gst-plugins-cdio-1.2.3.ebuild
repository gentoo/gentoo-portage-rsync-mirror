# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdio/gst-plugins-cdio-1.2.3.ebuild,v 1.5 2014/04/16 07:47:56 ago Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ppc64 ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/libcdio-0.80:="
DEPEND="${RDEPEND}"
