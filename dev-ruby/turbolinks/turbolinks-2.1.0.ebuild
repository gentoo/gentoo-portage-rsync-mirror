# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/turbolinks/turbolinks-2.1.0.ebuild,v 1.1 2013/12/18 13:03:38 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="Makes following links in your web application faster"
HOMEPAGE="https://github.com/dkubb/equalizer"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/coffee-rails
	dev-ruby/sprockets )"

RESTRICT="test"
