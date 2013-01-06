# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/volume/volume-1.0.ebuild,v 1.4 2009/03/13 00:11:35 tcunha Exp $

inherit elisp

DESCRIPTION="Tweak your sound card volume from Emacs"
HOMEPAGE="http://www.brockman.se/software/volume-el/"
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

# NOTE we might define the following which volume.el can work with by
# default, but volume.el can really work with anything.

# RDEPEND="|| ( media-sound/aumixer media-sound/alsa-utils )"

SITEFILE=50${PN}-gentoo.el
