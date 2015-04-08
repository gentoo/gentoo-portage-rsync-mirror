# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/letter_opener/letter_opener-1.3.0.ebuild,v 1.1 2014/12/13 07:36:44 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Preview mail in the browser instead of sending"
HOMEPAGE="https://github.com/ryanb/letter_opener"
SRC_URI="https://github.com/ryanb/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/mail:2.5 )"
ruby_add_rdepend "dev-ruby/launchy"

all_ruby_prepare() {
	sed -i -e "/[Bb]undler/d" Rakefile spec/spec_helper.rb || die
	sed -i -e '4irequire "letter_opener"' spec/spec_helper.rb || die
}
