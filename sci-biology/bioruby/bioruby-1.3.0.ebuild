# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioruby/bioruby-1.3.0.ebuild,v 1.1 2009/03/04 18:40:28 weaver Exp $

inherit ruby

DESCRIPTION="An integrated environment for bioinformatics using the Ruby language"
LICENSE="Ruby"
HOMEPAGE="http://www.bioruby.org/"
SRC_URI="http://www.${PN}.org/archive/${P}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~ppc ~x86 ~amd64"

USE_RUBY="ruby18"

src_install() {
	${RUBY} setup.rb install --prefix="${D}"
}
