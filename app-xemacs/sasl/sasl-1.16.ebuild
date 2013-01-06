# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/sasl/sasl-1.16.ebuild,v 1.5 2007/07/11 02:37:38 mr_bones_ Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Simple Authentication and Security Layer (SASL) library."
PKG_CAT="standard"

RDEPEND="app-xemacs/ecrypto
"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"

inherit xemacs-packages
