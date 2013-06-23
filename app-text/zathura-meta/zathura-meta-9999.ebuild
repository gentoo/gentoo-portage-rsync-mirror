# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-meta/zathura-meta-9999.ebuild,v 1.1 2013/06/23 13:06:01 xmw Exp $

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
