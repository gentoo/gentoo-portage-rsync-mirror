# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-a52dec/gst-plugins-a52dec-1.0.5.ebuild,v 1.7 2013/02/22 18:09:41 ago Exp $

EAPI="5"

inherit gst-plugins-ugly

KEYWORDS="~alpha amd64 arm ~hppa ia64 ppc ppc64 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="+orc"

RDEPEND="
	>=media-libs/a52dec-0.7.3
	orc? ( >=dev-lang/orc-0.4.16 )
"
DEPEND="${RDEPEND}"
