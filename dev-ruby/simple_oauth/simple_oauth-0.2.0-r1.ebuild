# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/simple_oauth/simple_oauth-0.2.0-r1.ebuild,v 1.1 2013/10/09 00:13:46 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Simply builds and verifies OAuth headers."
HOMEPAGE="https://github.com/laserlemon/simple_oauth"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

each_ruby_test() {
	export CI=true
	each_fakegem_test
}
