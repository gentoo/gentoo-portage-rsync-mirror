# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pdf-core/pdf-core-0.2.5.ebuild,v 1.4 2014/08/06 02:05:04 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="Implements low level PDF features for Prawn"
HOMEPAGE="http://github.com/prawnpdf/pdf-core/"

LICENSE="|| ( Ruby GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/pdf-inspector
	dev-ruby/pdf-reader )"

all_ruby_prepare() {
	sed -i -e "/[Bb]undler/d" spec/spec_helper.rb || die
}
