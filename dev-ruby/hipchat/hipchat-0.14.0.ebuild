# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hipchat/hipchat-0.14.0.ebuild,v 1.1 2013/12/13 04:27:36 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.textile"

inherit ruby-fakegem

DESCRIPTION="Ruby library to interact with HipChat"
HOMEPAGE="https://github.com/hipchat/hipchat-rb"
SRC_URI="https://github.com/hipchat/hipchat-rb/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RUBY_S="hipchat-rb-${PV}"

ruby_add_rdepend "dev-ruby/httparty"
ruby_add_bdepend "test? (
		dev-ruby/rr
		dev-ruby/rake
		dev-ruby/webmock
	)"

all_ruby_prepare() {
	sed -i -e '/bundler/d' Rakefile ${PN}.gemspec || die "sed failed"
	sed -i -e '/git ls-files/d' ${PN}.gemspec || die "sed failed"
}
