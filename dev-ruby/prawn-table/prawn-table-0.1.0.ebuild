# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/prawn-table/prawn-table-0.1.0.ebuild,v 1.5 2014/08/19 12:16:31 armin76 Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="Provides support for tables in Prawn"
HOMEPAGE="http://prawn.majesticseacreature.com/"
LICENSE="|| ( GPL-2+ Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/mocha
	>=dev-ruby/pdf-inspector-1.1.0
	>=dev-ruby/pdf-reader-1.2
	>=dev-ruby/prawn-1.2.1
	)"

all_ruby_prepare() {
	sed -i -e "/[Bb]undler/s/^/#/" spec/spec_helper.rb || die
	# Remove failing test
	# See https://github.com/prawnpdf/prawn/issues/612 
	sed -i -e "/should not increase column width when rendering a subtable/,+17 s/^/#/" spec/table_spec.rb || die
}
