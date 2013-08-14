# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-meta/zathura-meta-9999.ebuild,v 1.2 2013/08/14 09:27:31 patrick Exp $

EAPI=5

DESCRIPTION="Meta package for app-text/zathura plugins"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS=""
IUSE="cb +deprecated djvu +pdf postscript"

RDEPEND=">=app-text/zathura-9999[deprecated=]
	cb? ( >=app-text/zathura-cb-9999[deprecated=] )
	djvu? ( >=app-text/zathura-djvu-9999[deprecated=] )
	pdf? ( || (
		>=app-text/zathura-pdf-poppler-9999[deprecated=]
		>=app-text/zathura-pdf-mupdf-9999[deprecated=] ) )
	postscript? ( >=app-text/zathura-ps-9999[deprecated=] )"
