# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/modernizr/modernizr-2.6.2.ebuild,v 1.1 2013/12/13 12:31:46 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="none"

inherit ruby-fakegem

DESCRIPTION="Neatly packaged Modernizr JS assets for use in Sprockets or the Rails 3 asset pipeline."
HOMEPAGE="https://github.com/josh/ruby-modernizr"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
