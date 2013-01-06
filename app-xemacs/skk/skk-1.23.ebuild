# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/skk/skk-1.23.ebuild,v 1.11 2007/07/11 02:37:37 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="MULE: Japanese Language Input Method."
PKG_CAT="mule"

DEPEND="app-xemacs/viper
app-xemacs/mule-base
app-xemacs/elib
app-xemacs/xemacs-base
app-xemacs/apel
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
