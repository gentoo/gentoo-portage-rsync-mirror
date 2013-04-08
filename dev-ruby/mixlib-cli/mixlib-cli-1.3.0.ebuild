# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mixlib-cli/mixlib-cli-1.3.0.ebuild,v 1.1 2013/04/08 17:45:17 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Mixin for creating command line applications"
HOMEPAGE="http://github.com/opscode/mixlib-cli"
SRC_URI="https://github.com/opscode/${PN}/archive/${PV}.tar.gz -> ${P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""
