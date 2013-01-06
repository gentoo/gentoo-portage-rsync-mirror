# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bioruby/bioruby-1.4.2.ebuild,v 1.1 2011/12/26 05:16:30 weaver Exp $

EAPI=4

inherit ruby

DESCRIPTION="An integrated environment for bioinformatics using the Ruby language"
LICENSE="Ruby"
HOMEPAGE="http://www.bioruby.org/"
SRC_URI="http://www.${PN}.org/archive/${P}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

USE_RUBY="ruby18"

src_install() {
	${RUBY} setup.rb install --prefix="${D}"
}

src_test() {
	# NB: Some tests fail but don't raise an error.
	${RUBY} setup.rb test || die
}
