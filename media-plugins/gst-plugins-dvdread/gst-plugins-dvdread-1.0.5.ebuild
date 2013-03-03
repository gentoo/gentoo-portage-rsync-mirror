# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dvdread/gst-plugins-dvdread-1.0.5.ebuild,v 1.11 2013/03/03 12:50:38 ago Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/libdvdread"
DEPEND="${RDEPEND}"
