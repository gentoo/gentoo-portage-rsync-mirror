# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-1.0.5.ebuild,v 1.1 2013/01/22 22:27:16 eva Exp $

EAPI="5"

inherit gst-plugins-bad

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-libs/libmms-0.4"
DEPEND="${RDEPEND}"
